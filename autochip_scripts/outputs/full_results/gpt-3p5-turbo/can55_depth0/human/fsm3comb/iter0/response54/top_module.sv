module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

// State transition logic
always @(*) begin
    case(state)
        2'b00: begin
            if (in == 1'b0) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b01;
            end
        end
        2'b01: begin
            if (in == 1'b0) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b01;
            end
        end
        2'b10: begin
            if (in == 1'b0) begin
                next_state = 2'b00;
            end else begin
                next_state = 2'b11;
            end
        end
        2'b11: begin
            if (in == 1'b0) begin
                next_state = 2'b10;
            end else begin
                next_state = 2'b01;
            end
        end
    endcase
end

// Output logic
always @(state) begin
    case(state)
        2'b00: out = 1'b0;
        2'b01: out = 1'b0;
        2'b10: out = 1'b0;
        2'b11: out = 1'b1;
    endcase
end

endmodule
