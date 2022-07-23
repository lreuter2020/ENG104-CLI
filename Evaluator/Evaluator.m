classdef Evaluator
    %EVALUATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Functions
        Variables
    end
    
    methods
        function obj = Evaluator()
            addpath("./Evaluator/Functions/");
            %EVALUATOR Construct an instance of this class
            %   Detailed explanation goes here
            obj.Functions = [
                Function("principle_stress", @Principle_Stress, "Calculate the principle stresses.")
            ];
            
            obj.Variables = [
                Variable("sigma_x", "σₓ", "The normal stress in x-direction"), ...
                Variable("sigma_y", "σᵧ", "The normal stress in y-direction"), ...
                Variable("tau_x_y", "τₓᵧ", "The shear stress in xy-plane"), ...
                Variable("sigma_x_prime", "σₓ'", "The normal stress on specific plane in x'-direction"), ...
                Variable("sigma_y_prime", "σᵧ'", "The normal stress on specific plane in y'-direction"), ...
                Variable("tau_x_prime_y_prime", "τₓ'ᵧ'", "The shear stress in x'y'-plane"), ...
                Variable("sigma_1", "σ₁", "Principal stress"), ...
                Variable("sigma_2", "σ₂", "Principal stress"), ...
                Variable("tau_max", "τₘₐₓ", "In-Plane maximum shear stress"), ...
            ];
            
        end
        
        function [obj, errors] = Evaluate(obj, ast)
            errors = strings(0);
            if(ast.name == "exit")
               return 
            elseif(ast.name == "help")
                obj.Help();
                return
            end
            
            for f = obj.Functions
               if(ast.name == f.Name)
                    f.Call();
                    return
               end
            end
            
            errors = sprintf("ERROR: Unknown function %s", ast.name);
        end
        
        function obj = Clear(obj)
            for var = obj.Variables
               var.Clear(); 
            end
        end
        
        function Help(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            for f = obj.Functions
               fprintf("\t%s\n", f.String()); 
            end
            fprintf("\n");
        end
    end
end
