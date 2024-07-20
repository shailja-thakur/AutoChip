module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Declare state variables
    reg [0:0] state, next_state;
    
    // Define the states
    localparam A = 1'b0, B = 1'b1;
    
    // State update logic
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
