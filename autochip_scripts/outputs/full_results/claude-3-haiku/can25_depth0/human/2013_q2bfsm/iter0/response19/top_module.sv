module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam [1:0] 
    STATE_A = 2'b00,
    STATE_B = 2'b01,
    STATE_C = 2'b10,
    STATE_D = 2'b11;

reg [1:0] current_state, next_state;
reg x_history [1:0];

always @(posedge clk) begin
    if (!resetn) begin
        current_state <= STATE_A;
        f <= 0;
        g <= 0;
        x_history[0] <= 0;
        x_history[1] <= 0;
    end
    else begin
        current_state <= next_state;
        x_history[0] <= x;
        x_history[1] <= x_history[0];
    end
end

always @(*) begin
    next_state = current_state;
    f = 0;
    g = g;
    case (current_state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
                f = 1; // Set f to 1 for one clock cycle
            end
        end
        STATE_B: begin
            if (x_history[0] == 1 && x_history[1] == 0 && x == 1) begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            g = 1; // Set g to 1
            if (y == 1) begin
                next_state = STATE_D; // Maintain g = 1 permanently
            end
            else if (y == 0 && (x_history[0] != 1 || x_history[1] != 0 || x != 1)) begin
                next_state = STATE_A; // Set g = 0 permanently
            end
        end
        STATE_D: begin
            g = 1; // Maintain g = 1 permanently
        end
    endcase
end

endmodule
