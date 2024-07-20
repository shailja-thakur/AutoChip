module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00; // initial state S
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case(state)
            2'b00: begin // S
                if (data) begin
                    next_state = 2'b01; // S1
                end else begin
                    next_state = 2'b00; // S
                end
            end

            2'b01: begin // S1
                if (data) begin
                    next_state = 2'b10; // S11
                end else begin
                    next_state = 2'b00; // S
                end
            end

            2'b10: begin // S11
                if (data) begin
                    next_state = 2'b10; // S11
                end else begin
                    next_state = 2'b11; // S110
                end
            end

            2'b11: begin // S110
                if (data) begin
                    next_state = 2'b11; // Done
                end else begin
                    next_state = 2'b00; // S
                end
            end
        endcase
    end

    always @(state) begin
        if (state == 2'b11) begin // Done
            start_shifting = 1'b1;
        end else begin
            start_shifting = 1'b0;
        end
    end

endmodule
