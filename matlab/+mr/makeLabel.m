function label = makeLabel(str, varargin)
%makeLabel Create a ADC Label.
%   label=makeLabel() Create a Label event for ADC line
%                         Possible str values: 'SET','INC'
%
%   See also  Sequence.addBlock

persistent parser
if isempty(parser)
    parser = inputParser;
    parser.FunctionName = 'makeLabel';
    
    addOptional(parser, 'slc', NaN, @isnumeric);
    addOptional(parser, 'seg', NaN, @isnumeric);
    addOptional(parser, 'rep', NaN, @isnumeric);
    addOptional(parser, 'nav', NaN, @isnumeric);
    addOptional(parser, 'avg', NaN, @isnumeric);
    addOptional(parser, 'set', NaN, @isnumeric);
    addOptional(parser, 'eco', NaN, @isnumeric);
    addOptional(parser, 'phs', NaN, @isnumeric);
    addOptional(parser, 'sms', NaN, @isnumeric);
    addOptional(parser, 'lin', NaN, @isnumeric);
    addOptional(parser, 'par', NaN, @isnumeric);
%    addOptional(parser, 'system', mr.opts(), @isstruct);
    addParameter(parser, 'tag', NaN, @isnumeric); %XG: let's make extension more robust
end

if nargin<1
    error('makeLabelSet:invalidArguments','Must supply a header');
end

parse(parser, varargin{:});
opt = parser.Results;

str_num=find(strcmp(str,{'SET','INC'}));
assert(~isempty(str_num) && str_num>0,'makeLabel:invalidString',...
    'str (%s) is invalid',str);
switch(str)
    case 'SET'
        label.type = 'label';
        label.slc = opt.slc;
        label.rep = opt.rep;
        label.seg = opt.seg;
        label.nav = opt.nav;        
            assert(~(opt.nav ~= 0 && opt.nav ~= 1 && ~isnan(opt.nav)),'unknown value for NAV = %d \n', opt.nav);
        label.avg = opt.avg;
        label.set = opt.set;
        label.eco = opt.eco;
        label.phs = opt.phs;
        label.sms = opt.sms;
            assert(~(opt.sms ~= 0 && opt.sms ~= 1 && ~isnan(opt.sms)),'unknown value for SMS = %d \n', opt.sms);
        label.lin = opt.lin;
        label.par = opt.par;
        if isnan(opt.tag); label.tag = 2; else; label.tag = opt.tag;end %default 2, compatible for the previous version
    case 'INC'
        label.type = 'inclabel';
        label.slc = opt.slc;
        label.rep = opt.rep;
        label.seg = opt.seg;
        label.nav = opt.nav;
            assert(isnan(opt.nav),'Flags cannot be incremented. Use Set.\n');
        label.avg = opt.avg;
        label.set = opt.set;
        label.eco = opt.eco;
        label.phs = opt.phs;
        label.sms = opt.sms;
            assert(isnan(opt.sms),'Flags cannot be incremented. Use Set.\n');
        label.lin = opt.lin;
        label.par = opt.par;
        label.tag = opt.tag;
        if isnan(opt.tag); label.tag = 3; else; label.tag = opt.tag;end %default 3, compatible for the previous version
    otherwise
        disp('Unknown str')
end
end
