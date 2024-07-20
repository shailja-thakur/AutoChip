module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk) begin
        state <= y;
        case (state)
            3'b000: 
                if(x == 0) next_state = 3'b000;
                else next_state = 3'b001;
            3'b001: 
                if(x == 0) next_state = 3'b001;
                else next_state = 3'b100;
            3'b010:
                if(x == 0) next_state = 3'b010;
                else next_state = 3'b001;
            3'b011:
                if(x == 0) next_state = 3'b001;
                else next_state = 3'b010;
            3'b100:
                if(x == 0) next_state = 3'b011;
                else next_state = 3'b100;
            default: next_state = 3'b000;
        endcase

        Y0 <= next_state[0];
        
        // Output logic for z
        case (state)
            3'b011: z <= 1'b1;
            3'b100: z <= 1'b1;
            default: z <= 1'b0;
        endcase
    end
endmodule
