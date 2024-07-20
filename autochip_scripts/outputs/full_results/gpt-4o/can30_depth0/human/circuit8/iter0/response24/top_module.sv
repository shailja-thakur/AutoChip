module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg [1:0] state, next_state;

always @(posedge clock) begin
    state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: begin
            p = 0;
            q = 0;
            if (a) next_state = 2'b01;
            else next_state = 2'b00;
        end
        2'b01: begin
            p = 1;
            q = 0;
            next_state = 2'b10;
        end
        2'b10: begin
            p = 1;
            q = 0;
            if (a) next_state = 2'b11;
            else next_state = 2'b10;
        end
        2'b11: begin
            p = 1;
            q = 1;
            next_state = 2'b00;
        end
        default: begin
            p = 0;
            q = 0;
            next_state = 2'b00;
        end
    endcase
end

always @(negedge clock) begin
    case (state)
        2'b00: q <= 0;
        2'b01: q <= 0;
        2'b10: q <= 0;
        2'b11: q <= 1;
    endcase
end

endmodule
