module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define the states
    localparam A = 1'b0, B = 1'b1;
    
    // Define the state register
    reg state;
    
    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end
        else begin
            case (state)
                A: begin
                    if (in) begin
                        state <= A;
                    end
                    else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                end
            endcase
        end
    end
    
    // Output logic
    always @(*) begin
        if (state == B) begin
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end
    
endmodule
