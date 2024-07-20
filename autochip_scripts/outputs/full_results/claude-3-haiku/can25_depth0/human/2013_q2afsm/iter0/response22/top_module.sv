module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

localparam [1:0] STATE_A = 2'b00,
                 STATE_B = 2'b01,
                 STATE_C = 2'b10,
                 STATE_D = 2'b11;

reg [1:0] state, next_state;

// State Register
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

// Next State Logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            if (r[1]) begin
                next_state = STATE_B;
            end else if (r[2]) begin
                next_state = STATE_C;
            end else if (r[3]) begin
                next_state = STATE_D;
            end
        end
        STATE_B: begin
            if (r[1]) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_C: begin
            if (r[2]) begin
                next_state = STATE_C;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            next_state = STATE_A;
        end
    endcase
end

// Output Logic
assign g[1] = (state == STATE_B);
assign g[2] = (state == STATE_C);
assign g[3] = (state == STATE_D);

endmodule
