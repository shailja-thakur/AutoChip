module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

// State codes:
// A = 3'b000
// B = 3'b001
// C = 3'b010
// D = 3'b011
// E = 3'b100
// F = 3'b101

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

always @* begin
    case (state)
        3'b000:
            if (w)
                next_state = 3'b001;
            else
                next_state = 3'b000;
        
        3'b001:
            if (w)
                next_state = 3'b010;
            else
                next_state = 3'b011;
        
        3'b010:
            if (w)
                next_state = 3'b100;
            else
                next_state = 3'b011;
        
        3'b011:
            if (w)
                next_state = 3'b101;
            else
                next_state = 3'b000;
        
        3'b100:
            if (w)
                next_state = 3'b100;
            else
                next_state = 3'b011;
        
        3'b101:
            if (w)
                next_state = 3'b010;
            else
                next_state = 3'b011;
    endcase
end

always @* begin
    case (state)
        3'b000:
            z = 1'b0;
            
        3'b100, 3'b101:
            z = 1'b1;
            
        default:
            z = 1'b0;
    endcase
end

endmodule
