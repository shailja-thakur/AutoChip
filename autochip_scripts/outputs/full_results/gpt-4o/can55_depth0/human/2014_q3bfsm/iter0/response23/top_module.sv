module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    localparam S0 = 3'd0;
    localparam S1 = 3'd1;
    localparam S2 = 3'd2;
    localparam S3 = 3'd3;
    localparam S4 = 3'd4;

    reg [2:0] state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end 
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (x) ? S1 : S0;
            S1: next_state = (x) ? S4 : S1;
            S2: next_state = (x) ? S1 : S2;
            S3: next_state = (x) ? S2 : S1;
            S4: next_state = (x) ? S4 : S3;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S3: z = 1;
            S4: z = 1;
            default: z = 0;
        endcase
    end

endmodule
