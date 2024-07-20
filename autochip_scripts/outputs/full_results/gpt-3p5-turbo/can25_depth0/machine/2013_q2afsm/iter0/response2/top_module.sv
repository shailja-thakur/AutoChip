module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00; // Initialize state to A
    end else begin
        state <= next_state;
    end
end

always @(state, r) begin
    case (state)
        2'b00: begin // A
            if (r[1]) begin
                next_state = 2'b01; // Next state is B
            end else if (r[2]) begin
                next_state = 2'b10; // Next state is C
            end else if (r[3]) begin
                next_state = 2'b11; // Next state is D
            end else begin
                next_state = 2'b00; // Next state is A
            end
        end
        2'b01: begin // B
            if (r[1]) begin
                next_state = 2'b01; // Next state is B
            end else begin
                next_state = 2'b00; // Next state is A
            end
        end
        2'b10: begin // C
            if (r[2]) begin
                next_state = 2'b10; // Next state is C
            end else begin
                next_state = 2'b00; // Next state is A
            end
        end
        2'b11: begin // D
            if (r[3]) begin
                next_state = 2'b11; // Next state is D
            end else begin
                next_state = 2'b00; // Next state is A
            end
        end
    endcase
end

assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // If current state is B, g[1] is high
assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // If current state is C, g[2] is high
assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // If current state is D, g[3] is high

endmodule
