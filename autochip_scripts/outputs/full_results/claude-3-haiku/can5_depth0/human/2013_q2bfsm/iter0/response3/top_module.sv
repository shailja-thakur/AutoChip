module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

reg [1:0] state, next_state;
reg [1:0] x_history;

always @(posedge clk) begin
    if (!resetn) begin
        state <= STATE_A;
        f <= 0;
        g <= 0;
        x_history <= 0;
    end
    else begin
        state <= next_state;
        
        // Update x history
        x_history <= {x_history[0:0], x};
        
        // Update outputs
        if (state == STATE_B) begin
            f <= 1;
        end
        else begin
            f <= 0;
        end
        
        if (state == STATE_D) begin
            g <= 1;
        end
        else if (state == STATE_C && y == 0) begin
            g <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            if (resetn) begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            if (x_history == 3'b101) begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (y == 1) begin
                next_state = STATE_D;
            end
            else if (y == 0) begin
                next_state = STATE_A;
            end
        end
        STATE_D: begin
            // Remain in STATE_D
        end
    endcase
end

endmodule
