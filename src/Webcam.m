classdef Webcam < handle
    
    properties (Access = private)
        id_ % ID of the session.
    end
    
    methods
        function this = Webcam(dev, w, h)
            this.id_ = WebcamMexWrapper('new', dev, w, h);
        end
        
        function delete(this)
            WebcamMexWrapper('delete', this.id_);
        end
        
        %% All other methods
        function varargout = subsref(this, s)
            if numel(s) < 2 || ~isequal(s(1).type, '.') || ~isequal(s(2).type, '()')
                error('Not a valid indexing expression')
            end
            assert(isscalar(this));
            [varargout{1:nargout}] = WebcamMexWrapper(s(1).subs, this.id_, s(2).subs{:});
        end
        
    end
    
end
