module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter S = 2'b00, S1 = 2'b01, S11 = 2'b10, S110 = 2'b11, Done = 3'b100;
    reg [2:0] state, next_state;

    // State register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S: begin
                if (data) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
            end
            S1: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = S;
                end
            end
            S11: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = S110;
                end
            end
            S110: begin
                if (data) begin
                    next_state = Done;
                end else begin
                    next_state = S;
                end
            end
            Done: begin
                next_state = Done;
            end
            default: begin
                next_state = S;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == Done) begin
            start_shifting = 1'b1;
        end else begin
            start_shifting = 1'b0;
        end
    end

endmodule
