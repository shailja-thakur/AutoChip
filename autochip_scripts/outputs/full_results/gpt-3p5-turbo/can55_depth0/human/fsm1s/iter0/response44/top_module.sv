module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    // Define the states for the state machine
    parameter B = 0;
    parameter A = 1;
    
    // Define the current state variable
    reg [1:0] state;
    
    // Define the output variable
    reg out;
    
    always @(posedge clk) begin
        if (reset) begin
            // Reset the state machine to B
            state <= B;
            out <= 1;
        end else begin
            // Determine the next state and output based on the current state and input
            case (state)
                B: begin
                    if (in) begin
                        state <= B;
                        out <= 1;
                    end else begin
                        state <= A;
                        out <= 0;
                    end
                end
                
                A: begin
                    if (in) begin
                        state <= A;
                        out <= 0;
                    end else begin
                        state <= B;
                        out <= 1;
                    end
                end
            endcase
        end
    end
endmodule
