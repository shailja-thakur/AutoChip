module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state, next_state;

always @(posedge clk or posedge reset) begin
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
            z = 1'b0;
            if (x == 1'b0) begin
                next_state = 3'b000;
            end
            else begin
                next_state = 3'b001;
            end
        end
        3'b001: begin
            z = 1'b0;
            if (x == 1'b0) begin
                next_state = 3'b001;
            end
            else begin
                next_state = 3'b100;
            end
        end
        3'b010: begin
            z = 1'b0;
            if (x == 1'b0) begin
                next_state = 3'b010;
            end
            else begin
                next_state = 3'b001;
            end
        end
        3'b011: begin
            z = 1'b1;
            if (x == 1'b0) begin
                next_state = 3'b001;
            end
            else begin
                next_state = 3'b010;
            end
        end
        3'b100: begin
            z = 1'b1;
            if (x == 1'b0) begin
                next_state = 3'b011;
            end
            else begin
                next_state = 3'b100;
            end
        end
        default: begin
            z = 1'b0;
            next_state = 3'b000;
        end
    endcase
end

endmodule
