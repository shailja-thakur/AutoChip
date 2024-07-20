module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00; // Set state to A on reset
    end else begin
        state <= next_state;
    end
end

always @* begin
    next_state = state;

    case (state)
        2'b00: begin // State A
            if (r[2]) begin
                next_state = 2'b01; // Next state is B if r[2] is high
            end else if (r[1]) begin
                next_state = 2'b10; // Next state is C if r[1] is high
            end else if (r[0]) begin
                next_state = 2'b11; // Next state is D if r[0] is high
            end
        end

        2'b01: begin // State B
            if (!r[2]) begin
                next_state = 2'b00; // Next state is A if r[2] is low
            end
        end

        2'b10: begin // State C
            if (!r[1]) begin
                next_state = 2'b00; // Next state is A if r[1] is low
            end
        end

        2'b11: begin // State D
            if (!r[0]) begin
                next_state = 2'b00; // Next state is A if r[0] is low
            end
        end
    endcase
end

always @* begin
    g[2] = (state == 2'b01); // Set g[2] high if state is B
    g[1] = (state == 2'b10); // Set g[1] high if state is C
    g[0] = (state == 2'b11); // Set g[0] high if state is D
end

endmodule
