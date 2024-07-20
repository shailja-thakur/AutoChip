module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        3'b000: begin
            if (x) begin
                next_state = 3'b001;
                z = 0;
            end else begin
                next_state = 3'b000;
                z = 0;
            end
        end
        3'b001: begin
            if (x) begin
                next_state = 3'b100;
                z = 0;
            end else begin
                next_state = 3'b001;
                z = 0;
            end
        end
        3'b010: begin
            if (x) begin
                next_state = 3'b001;
                z = 0;
            end else begin
                next_state = 3'b010;
                z = 0;
            end
        end
        3'b011: begin
            if (x) begin
                next_state = 3'b100;
                z = 1;
            end else begin
                next_state = 3'b010;
                z = 1;
            end
        end
        3'b100: begin
            if (x) begin
                next_state = 3'b100;
                z = 1;
            end else begin
                next_state = 3'b011;
                z = 1;
            end
        end
        default: begin
            next_state = 3'b000;
            z = 0;
        end
    endcase
end

endmodule
