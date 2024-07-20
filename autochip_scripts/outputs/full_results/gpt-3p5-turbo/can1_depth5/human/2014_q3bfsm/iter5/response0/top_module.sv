module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] y;
    wire [2:0] next_y; // Add a wire to compute the next state
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            y <= 3'b000;
        else
            y <= next_y; // Assign the next state to the current state
    end
    
    always @* begin
        case (y)
            3'b000: next_y = (x == 1) ? 3'b001 : 3'b000;
            3'b001: next_y = (x == 1) ? (y == 3'b011) ? 3'b010 : 3'b100 : 3'b001;
            3'b010: next_y = (x == 1) ? 3'b001 : 3'b001;
            3'b011: next_y = (x == 1) ? 3'b001 : 3'b010;
            3'b100: next_y = (x == 1) ? 3'b100 : 3'b011;
            default: next_y = 3'b000;
        endcase
    end
    
    assign z = (y == 3'b100) || (y == 3'b010) ? 1'b1 : 1'b0;
    
endmodule
