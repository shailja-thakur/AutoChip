module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [2:0] state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 3'b000; // initial state S0
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;
        case (state)
            3'b000: begin // S0
                if (x) begin
                    next_state = 3'b001; // S1
                end else begin
                    next_state = 3'b000; // stay in S0
                end
            end
            3'b001: begin // S1
                if (x) begin
                    next_state = 3'b001; // stay in S1
                end else begin
                    next_state = 3'b010; // S10
                end
            end
            3'b010: begin // S10
                if (x) begin
                    next_state = 3'b011; // G1
                end else begin
                    next_state = 3'b000; // S0
                end
            end
            3'b011: begin // G1
                if (y) begin
                    next_state = 3'b101; // P1
                end else begin
                    next_state = 3'b100; // G2
                end
            end
            3'b100: begin // G2
                if (y) begin
                    next_state = 3'b101; // P1
                end else begin
                    next_state = 3'b110; // P0
                end
            end
            3'b101: begin // P1
                next_state = 3'b101; // stay in P1
            end
            3'b110: begin // P0
                next_state = 3'b110; // stay in P0
            end
        endcase
    end

    always @(state) begin
        case (state)
            3'b000: begin
                f = 1'b0;
                g = 1'b0;
            end
            3'b001: begin
                f = 1'b0;
                g = 1'b0;
            end
            3'b010: begin
                f = 1'b0;
                g = 1'b0;
            end
            3'b011: begin
                f = 1'b0;
                g = 1'b1;
            end
            3'b100: begin
                f = 1'b0;
                g = 1'b1;
            end
            3'b101: begin
                f = 1'b0;
                g = 1'b1;
            end
            3'b110: begin
                f = 1'b0;
                g = 1'b0;
            end
            default: begin
                f = 1'b0;
                g = 1'b0;
            end
        endcase
    end

endmodule
