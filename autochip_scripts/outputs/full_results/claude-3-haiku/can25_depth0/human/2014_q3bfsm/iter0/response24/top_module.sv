module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        present_state <= 3'b000;
    end
    else begin
        present_state <= next_state;
    end
end

always @(*) begin
    case (present_state)
        3'b000: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end
            else begin
                next_state = 3'b001;
            end
            z = 1'b0;
        end
        3'b001: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end
            else begin
                next_state = 3'b100;
            end
            z = 1'b0;
        end
        3'b010: begin
            if (x == 1'b0) begin
                next_state = 3'b010;
            end
            else begin
                next_state = 3'b001;
            end
            z = 1'b0;
        end
        3'b011: begin
            if (x == 1'b0) begin
                next_state = 3'b001;
            end
            else begin
                next_state = 3'b010;
            end
            z = 1'b1;
        end
        3'b100: begin
            if (x == 1'b0) begin
                next_state = 3'b011;
            end
            else begin
                next_state = 3'b100;
            end
            z = 1'b1;
        end
        default: begin
            next_state = 3'b000;
            z = 1'b0;
        end
    endcase
end

endmodule
