module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] y, next_y;

    // Sequential logic (state register)
    always @(posedge clk) begin
        if (reset)
            y <= 3'b000;
        else
            y <= next_y;
    end

    // Combinational logic (next state and output logic)
    always @(*) begin
        case (y)
            3'b000: begin
                next_y = x ? 3'b001 : 3'b000;
                z = 1'b0;
            end
            3'b001: begin
                next_y = x ? 3'b100 : 3'b001;
                z = 1'b0;
            end
            3'b010: begin
                next_y = x ? 3'b001 : 3'b010;
                z = 1'b0;
            end
            3'b011: begin
                next_y = x ? 3'b010 : 3'b001;
                z = 1'b1;
            end
            3'b100: begin
                next_y = x ? 3'b100 : 3'b011;
                z = 1'b1;
            end
            default: begin
                next_y = 3'b000;
                z = 1'b0;
            end
        endcase
    end

endmodule
