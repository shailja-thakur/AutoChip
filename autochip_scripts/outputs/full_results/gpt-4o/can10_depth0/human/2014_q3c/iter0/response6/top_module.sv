module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    reg [2:0] next_state;

    // Define the state assignment table as per the given description
    always @(posedge clk) begin
        case (y)
            3'b000: begin
                next_state = (x == 0) ? 3'b000 : 3'b001;
                z = 0;
            end
            3'b001: begin
                next_state = (x == 0) ? 3'b001 : 3'b100;
                z = 0;
            end
            3'b010: begin
                next_state = (x == 0) ? 3'b010 : 3'b001;
                z = 0;
            end
            3'b011: begin
                next_state = (x == 0) ? 3'b001 : 3'b010;
                z = 1;
            end
            3'b100: begin
                next_state = (x == 0) ? 3'b011 : 3'b100;
                z = 1;
            end
            default: begin
                next_state = 3'b000;
                z = 0;
            end
        endcase
    end

    // Assign Y0 as the next state bit Y[0]
    always @(posedge clk) begin
        Y0 <= next_state[0];
    end
endmodule
