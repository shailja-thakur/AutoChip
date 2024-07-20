module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    localparam S000 = 3'b000;
    localparam S001 = 3'b001;
    localparam S010 = 3'b010;
    localparam S011 = 3'b011;
    localparam S100 = 3'b100;

    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S000: next_state = (x) ? S001 : S000;
            S001: next_state = (x) ? S100 : S001;
            S010: next_state = (x) ? S001 : S010;
            S011: next_state = (x) ? S010 : S001;
            S100: next_state = (x) ? S100 : S011;
            default: next_state = S000;
        endcase
    end

    // Output logic based on the next state
    always @(*) begin
        case (next_state)
            S000, S001, S010: z = 1'b0;
            S011, S100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S000;
        else
            current_state <= next_state;
    end

endmodule
