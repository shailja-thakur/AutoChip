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
            state <= 0; // initial state S0
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;
        case (state)
            0: begin // S0
                if (x) begin
                    next_state = 1; // S1
                end else begin
                    next_state = 0; // stay in S0
                end
            end
            1: begin // S1
                if (x) begin
                    next_state = 1; // stay in S1
                end else begin
                    next_state = 2; // S10
                end
            end
            2: begin // S10
                if (x) begin
                    next_state = 3; // G1
                end else begin
                    next_state = 0; // S0
                end
            end
            3: begin // G1
                if (y) begin
                    next_state = 4; // P1
                end else begin
                    next_state = 5; // G2
                end
            end
            5: begin // G2
                if (y) begin
                    next_state = 4; // P1
                end else begin
                    next_state = 6; // P0
                end
            end
            6: begin // P0
                next_state = 6; // stay in P0
            end
            4: begin // P1
                next_state = 4; // stay in P1
            end
        endcase
    end
	
    always @(posedge clk) begin
        f <= (state == 3); // f is 1 when the state is G1
        g <= ((state == 3) || (state == 5) || (state == 4)); // g is 1 when the state is G1 or G2 or P1
    end

endmodule
