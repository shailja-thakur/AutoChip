module top_module (
        input clk,
        input resetn,
        input x,
        input y,
        output reg f,
        output reg g
    );
    reg [1:0] state;
    reg [2:0] x_history;
    reg [1:0] y_timer;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00;      // Reset state A
            f <= 1'b0;           // Reset f
            g <= 1'b0;           // Reset g
            x_history <= 3'b000; // Reset x_history
            y_timer <= 2'b00;    // Reset y_timer
        end
        else begin
            case (state)
                2'b00: begin       // state A
                    f <= 1'b0;     // Reset f
                    if (resetn)    // Transition to state B
                        state <= 2'b01;
                end
                2'b01: begin       // state B
                    if (x)         // Transition to state C
                        state <= 2'b10;
                end
                2'b10: begin       // state C
                    if (!x)        // Transition back to state B
                        state <= 2'b01;
                    else if (x_history == 3'b101) begin   // x = 101
                        state <= 2'b11;                  // Transition to state D
                        y_timer <= 2'b00;                // Reset y_timer
                    end
                end
                2'b11: begin       // state D
                    if (y)         // Set g = 1 permanently
                        g <= 1'b1;
                    else if (y_timer >= 2'b11)    // y did not become 1 within two clock cycles
                        g <= 1'b0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        x_history <= {x_history[1:0], x};   // Shift in new x value

        if (state == 2'b11 && g == 1'b0)    // Reset y_timer
            y_timer <= 2'b00;
        else if (y_timer < 2'b11)           // Increment y_timer
            y_timer <= y_timer + 1'b1;
    end

endmodule
