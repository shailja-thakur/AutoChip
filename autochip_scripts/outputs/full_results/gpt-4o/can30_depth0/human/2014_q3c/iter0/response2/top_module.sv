module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] next_state;
    
    always @(*) begin
        case (y)
            3'b000: begin
                if (x == 0) next_state = 3'b000;
                else next_state = 3'b001;
                z = 0;
            end
            3'b001: begin
                if (x == 0) next_state = 3'b001;
                else next_state = 3'b100;
                z = 0;
            end
            3'b010: begin
                if (x == 0) next_state = 3'b010;
                else next_state = 3'b001;
                z = 0;
            end
            3'b011: begin
                if (x == 0) next_state = 3'b001;
                else next_state = 3'b010;
                z = 1;
            end
            3'b100: begin
                if (x == 0) next_state = 3'b011;
                else next_state = 3'b100;
                z = 1;
            end
            default: begin
                next_state = 3'b000;
                z = 0;
            end
        endcase
    end

    always @(posedge clk) begin
        Y0 <= next_state[0];
    end

endmodule
