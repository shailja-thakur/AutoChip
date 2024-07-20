module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] state;
    reg [2:0] next_state;
    
    // State transitions
    always @(*) begin
        case (state)
            3'b000: next_state = (x == 0) ? 3'b000 : 3'b001;
            3'b001: next_state = (x == 0) ? 3'b001 : 3'b100;
            3'b010: next_state = (x == 0) ? 3'b010 : 3'b001;
            3'b011: next_state = (x == 0) ? 3'b001 : 3'b010;
            3'b100: next_state = (x == 0) ? 3'b011 : 3'b100;
            default: next_state = 3'b000;
        endcase
    end

    // State update on clock edge
    always @(posedge clk) begin
        state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            3'b000: z = 0;
            3'b001: z = 0;
            3'b010: z = 0;
            3'b011: z = 1;
            3'b100: z = 1;
            default: z = 0;
        endcase
    end

    // Y0 is the least significant bit of next_state
    always @(*) begin
        Y0 = next_state[0];
    end

    // Initialize state
    initial begin
        state = 3'b000;
    end
endmodule
