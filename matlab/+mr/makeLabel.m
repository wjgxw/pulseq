function out = makeLabel(type, label, value)
%makeLabel Create a ADC Label.
%   label=makeLabel() Create a Label event for ADC line
%         Possible type values: 'SET','INC'
%         label should be one of: {'SLC'},{'SEG'},{'REP'},{'NAV'},{'AVG'},{'SET'},{'ECO'},{'PHS'},{'SMS'},{'LIN'},{'PAR'}
%         value: numeric value of the parameter or 
%                true/galse for a flag
%
%   See also  Sequence.addBlock, mr.getSupportedLabels


supported_labels=mr.getSupportedLabels();
if nargin~=3
    error('makeLabel:invalidArguments','Must supply exactly 3 parameters');
end
if ~any(ismember(supported_labels,label))
    error('makeLabel:invalidArguments','Must supply a valid label');
end
if ~any(ismember({'SET','INC'},type))
    error('makeLabel:invalidArguments','Must supply a valid type');
end
if ~isnumeric(value)
    error('makeLabel:invalidArguments','Must supply a valid numeric value');
end

switch(type)
    case 'SET'
        out.type = 'labelset';
    case 'INC'
        out.type = 'labelinc';
    otherwise
        disp('Unknown str')
end
out.label=label;
out.value=value;
end
