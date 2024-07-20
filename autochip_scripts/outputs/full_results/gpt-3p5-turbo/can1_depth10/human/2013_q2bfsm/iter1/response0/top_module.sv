module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    reg [2:0] state, next_state;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // reset state and outputs
            f <= 0;
            g <= 0;
            state <= 3'b000;
        end else begin
            // next state logic
            case (state)
                3'b000: begin // beginning state (A)
                    f <= 0;
                    if (x) begin
                        state <= 3'b001;
                    end
                end
                3'b001: begin // wait for x = 0
                    if (!x) begin
                        state <= 3'b010;
                    end
                end
                3'b010: begin // wait for x = 1
                    if (x) begin
                        state <= 3'b011;
                    end
                end
                3'b011: begin // wait for x = 0
                    if (!x) begin
                        state <= 3'b100;
                    end
                end
                3'b100: begin // check y
                    if (y) begin
                        state <= 3'b110;
                        g <= 1;
                    end else begin
                        state <= 3'b101;
                    end
                end
                3'b101: begin // wait for y = 1
                    if (y) begin
                        state <= 3'b110;
                        g <= 1;
                    end
                end
                3'b110: begin // maintain g = 1
                    if (!y) begin
                        state <= 3'b111;
                    end
                end
                3'b111: begin // reset
                    f <= 0;
                    g <= 0;
                    state <= 3'b000;
                end
            endcase
        end
    end
endmodule
