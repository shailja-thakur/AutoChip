module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    reg [1:0] state;
    reg [2:0] history;
    reg [1:0] x_timer;
    reg [1:0] y_timer;
    reg [1:0] reset_timer;
    reg g_buffer;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00; // state A
            f <= 1'b0; // reset f
            g <= 1'b0; // reset g
            history <= 3'b000; // reset history
            x_timer <= 2'b00; // reset x_timer
            y_timer <= 2'b00; // reset y_timer
            reset_timer <= 2'b00; // reset reset_timer
        end
        else begin
            case (state)
                2'b00: begin // state A
                    f <= 1'b0; // reset f
                    g <= 1'b0; // reset g
                    if (resetn == 1'b1) begin
                        state <= 2'b01; // transition to state B
                        reset_timer <= 2'b00; // reset reset_timer
                    end
                end
                2'b01: begin // state B
                    if (reset_timer < 2'b11) begin
                        reset_timer <= reset_timer + 1'b1; // increment reset_timer
                        f <= 1'b1; // set f = 1
                    end
                    else begin
                        f <= 1'b0; // reset f
                        if (x == 1'b1) begin
                            state <= 2'b10; // transition to state C
                            x_timer <= 2'b00; // reset x_timer
                        end
                    end
                end
                2'b10: begin // state C
                    if (x == 1'b0) begin
                        state <= 2'b01; // transition back to state B
                        x_timer <= 2'b00; // reset x_timer
                    end
                    else begin
                        if (x_timer < 2'b11) begin
                            x_timer <= x_timer + 1'b1; // increment x_timer
                        end
                        else if (history == 3'b101) begin
                            state <= 2'b11; // transition to state D
                            y_timer <= 2'b00; // reset y_timer
                        end
                    end
                end
                2'b11: begin // state D
                    if (y == 1'b1) begin
                        g <= 1'b1; // set g = 1
                    end
                    else if (g_buffer == 1'b1 && y_timer < 2'b11) begin
                        g <= 1'b1; // set g = 1
                        y_timer <= y_timer + 1'b1; // increment y_timer
                    end
                    else if (g_buffer == 1'b1 && y_timer == 2'b11) begin
                        g <= 1'b0; // set g = 0
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        g_buffer <= g; // store previous value of g in g_buffer
        history <= {history[1:0], x}; // shift in new x value
    end

endmodule
