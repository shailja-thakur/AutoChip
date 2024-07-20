module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [3:0] state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 4'b0000; // initial state S0
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;
        case (state)
            4'b0000: begin // S0
                if (x) begin
                    next_state = 4'b0001; // S1
                end else begin
                    next_state = 4'b0000; // stay in S0
                end
            end
            4'b0001: begin // S1
                if (x) begin
                    next_state = 4'b0001; // stay in S1
                end else begin
                    next_state = 4'b1010; // S10
                end
            end
            4'b1010: begin // S10
                if (x) begin
                    next_state = 4'b0111; // G1
                end else begin
                    next_state = 4'b0000; // S0
                end
            end
            4'b0111: begin // G1
                if (y) begin
                    next_state = 4'b1101; // P1
                end else begin
                    next_state = 4'b1001; // G2
                end
            end
            4'b1001: begin // G2
                if (y) begin
                    next_state = 4'b1101; // P1
                end else begin
                    next_state = 4'b0000; // S0
                end
            end
            4'b1101: begin // P1
                next_state = 4'b1101; // stay in P1
            end
        endcase
    end

    always @(posedge clk) begin
        case (state)
            4'b1010: f <= 1; // f is 1 when the state is B
            default: f <= 0;
        endcase
        case (state)
            4'b0111: g <= 1; // g is 1 when the state is G1
            4'b1001: g <= 1; // g is 1 when the state is G2
            4'b1101: g <= 1; // g is 1 when the state is P1
            default: g <= 0;
        endcase
    end

endmodule
