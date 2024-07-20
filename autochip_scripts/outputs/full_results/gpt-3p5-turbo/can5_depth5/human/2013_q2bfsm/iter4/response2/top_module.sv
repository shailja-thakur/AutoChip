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
    reg [1:0] x_count;
    reg [1:0] y_count;
    reg [1:0] reset_count;
    reg g_update;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b00; // state A
            f <= 1'b0; // reset f
            g <= 1'b0; // reset g
            history <= 3'b000; // reset history
            x_count <= 2'b00;
            y_count <= 2'b00;
            reset_count <= 2'b00;
            g_update <= 1'b0;
        end
        else begin
            case (state)
                2'b00: begin // state A
                    f <= 1'b0; // reset f
                    if (resetn == 1'b1)
                        state <= 2'b01; // transition to state B
                end
                2'b01: begin // state B
                    if (x_count == 2'b11)
                        state <= 2'b10; // transition to state C
                    else
                        x_count <= x_count + 1'b1; // increment x_count
                end
                2'b10: begin // state C
                    if (x == 1'b0) begin
                        if (history == 3'b101)
                            state <= 2'b11; // transition to state D
                        else begin
                            state <= 2'b01; // transition back to state B
                            x_count <= 2'b00; // reset x_count
                        end
                    end
                    else
                        history <= {history[1:0], x}; // shift in new x value
                end
                2'b11: begin // state D
                    if (g_update && y_count == 2'b00) begin
                        if (y == 1'b1) begin
                            g <= 1'b1; // set g = 1
                            y_count <= 2'b10; // update y_count
                        end
                        else begin
                            g <= 1'b0; // set g = 0
                            y_count <= 2'b11; // update y_count
                        end
                    end
                    else if (g_update && y_count == 2'b11) begin
                        g <= 1'b0; // set g = 0
                    end
                    else begin
                        if (y == 1'b0)
                            y_count <= y_count + 1'b1; // increment y_count
                    end
                end
            endcase
            g_update <= 1'b1;
        end
    end
    
    always @(negedge resetn or posedge clk) begin
        if (~resetn) begin
            reset_count <= 2'b00;
        end
        else begin
            if (reset_count == 2'b01) begin
                f <= 1'b1; // set f = 1
            end
            else if (reset_count == 2'b10) begin
                f <= 1'b0; // reset f
            end
            if (state == 2'b00 && resetn == 1'b1)
                reset_count <= reset_count + 1'b1; // increment reset_count
        end
    end
endmodule
