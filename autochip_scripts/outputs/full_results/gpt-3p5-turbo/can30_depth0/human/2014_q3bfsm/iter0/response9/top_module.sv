module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        present_state <= 3'b000;
    end else begin
        present_state <= next_state;
    end
end

always @(present_state, x) begin
    case (present_state)
        3'b000:
            if (x == 1'b0) begin
                next_state = 3'b000;
                z = 1'b0;
            end else begin
                next_state = 3'b001;
                z = 1'b0;
            end
        3'b001:
            if (x == 1'b0) begin
                next_state = 3'b001;
                z = 1'b0;
            end else begin
                next_state = 3'b100;
                z = 1'b0;
            end
        3'b010:
            if (x == 1'b0) begin
                next_state = 3'b010;
                z = 1'b0;
            end else begin
                next_state = 3'b001;
                z = 1'b0;
            end
        3'b011:
            if (x == 1'b0) begin
                next_state = 3'b001;
                z = 1'b1;
            end else begin
                next_state = 3'b010;
                z = 1'b0;
            end
        3'b100:
            if (x == 1'b0) begin
                next_state = 3'b011;
                z = 1'b1;
            end else begin
                next_state = 3'b100;
                z = 1'b0;
            end
    endcase
end

endmodule
