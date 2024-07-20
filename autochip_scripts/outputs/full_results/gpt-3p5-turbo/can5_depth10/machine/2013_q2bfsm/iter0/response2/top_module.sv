module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [3:0] state;
    reg [1:0] next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 4'b00; // initial state is A
        end else begin
            state <= next_state;
        end
    end

    always @(state or x) begin
        case (state)
            2'b00: begin // A state
                if (x) begin
                    next_state = 2'b01; // B state
                end else begin
                    next_state = 2'b00; // A state
                end
            end
            2'b01: begin // B state
                next_state = 2'b10; // S0 state
            end
            2'b10: begin // S0 state
                if (x) begin
                    next_state = 2'b11; // S1 state
                end else begin
                    next_state = 2'b10; // S0 state
                end
            end
            2'b11: begin // S1 state
                if (x) begin
                    next_state = 2'b11; // S1 state
                end else begin
                    next_state = 2'b1010; // S10 state
                end
            end
            4'b1010: begin // S10 state
                if (x) begin
                    next_state = 4'b1000; // G1 state
                end else begin
                    next_state = 2'b10; // S0 state
                end
            end
            4'b1000: begin // G1 state
                if (y) begin
                    next_state = 4'b1001; // P1 state
                end else begin
                    next_state = 4'b101; // G2 state
                end
            end
            4'b101: begin // G2 state
                if (y) begin
                    next_state = 4'b1001; // P1 state
                end else begin
                    next_state = 4'b1000; // G1 state
                end
            end
            4'b1001: begin // P1 state
                next_state = 4'b1001; // P1 state
            end
            default: begin
                next_state = 4'b00; // A state
            end
        endcase
    end

    always @(state) begin
        case (state)
            2'b01: begin // B state
                f = 1'b1;
            end
            4'b1000, 4'b101, 4'b1001: begin // G1, G2, P1 states
                g = 1'b1;
            end
            default: begin
                g = 1'b0;
            end
        endcase
    end

endmodule
