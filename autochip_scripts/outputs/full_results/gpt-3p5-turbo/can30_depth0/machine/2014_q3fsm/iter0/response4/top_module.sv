module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define states
    parameter A = 1;
    parameter B = 2;
    parameter C = 3;
    parameter S10 = 4;
    parameter S11 = 5;
    parameter S20 = 6;
    parameter S21 = 7;
    parameter S22 = 8;
    
    // Define state variable and next state variable
    reg [3:0] state;
    reg [3:0] next_state;
    
    // Initialize state with A
    initial begin
        state = A;
        next_state = A;
    end
    
    // Sequential logic for state transition and output generation
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            next_state <= A;
        end else begin
            state <= next_state;
            case (state)
                A: begin
                    if (s) begin
                        next_state <= B;
                    end
                end
                
                B, C: begin
                    if (w) begin
                        next_state <= S11;
                    end else begin
                        next_state <= S10;
                    end
                end
                
                S10: begin
                    if (w) begin
                        next_state <= S21;
                    end else begin
                        next_state <= S20;
                    end
                end
                
                S11: begin
                    if (w) begin
                        next_state <= S22;
                    end else begin
                        next_state <= S21;
                    end
                end
                
                S20: begin
                    next_state <= B;
                end
                
                S21: begin
                    if (w) begin
                        next_state <= C;
                    end else begin
                        next_state <= B;
                    end
                end
                
                S22: begin
                    if (w) begin
                        next_state <= B;
                    end else begin
                        next_state <= C;
                    end
                end
            endcase
        end
    end
    
    // Output generation
    always @(state) begin
        case (state)
            B, C, S10, S11, S20, S21, S22: begin
                z <= 1;
            end
            
            default: begin
                z <= 0;
            end
        endcase
    end

endmodule
