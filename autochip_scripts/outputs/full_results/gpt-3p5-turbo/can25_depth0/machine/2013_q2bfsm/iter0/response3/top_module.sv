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
        if (~resetn) begin
            state <= 3'b0; // A state
            f <= 1'b0;
            g <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                3'b000: begin // A state
                    next_state = 3'b001; // B state
                    f <= 1'b0;
                    g <= 1'b0;
                end
                3'b001: begin // B state
                    next_state = 3'b100; // S0 state
                    f <= 1'b1;
                    g <= 1'b0;
                end
                3'b100: begin // S0 state
                    if (x) begin
                        next_state = 3'b010; // S1 state
                    end else begin
                        next_state = 3'b100; // S0 state
                    end
                    f <= 1'b0;
                    g <= 1'b0;
                end
                3'b010: begin // S1 state
                    if (x) begin
                        next_state = 3'b010; // S1 state
                    end else begin
                        next_state = 3'b101; // S10 state
                    end
                    f <= 1'b0;
                    g <= 1'b0;
                end
                3'b101: begin // S10 state
                    if (x) begin
                        next_state = 3'b110; // G1 state
                    end else begin
                        next_state = 3'b100; // S0 state
                    end
                    f <= 1'b0;
                    g <= 1'b0;
                end
                3'b110: begin // G1 state
                    if (y) begin
                        next_state = 3'b011; // P1 state
                    end else begin
                        next_state = 3'b111; // G2 state
                    end
                    f <= 1'b0;
                    g <= 1'b1;
                end
                3'b111: begin // G2 state
                    if (y) begin
                        next_state = 3'b011; // P1 state
                    end else begin
                        next_state = 3'b110; // G1 state
                    end
                    f <= 1'b0;
                    g <= 1'b1;
                end
                3'b011: begin // P1 state
                    next_state = 3'b011; // P1 state
                    f <= 1'b0;
                    g <= 1'b1;
                end
            endcase
        end
    end

endmodule
