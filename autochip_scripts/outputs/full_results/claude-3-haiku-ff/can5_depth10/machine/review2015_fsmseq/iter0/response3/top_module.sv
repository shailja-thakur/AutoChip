module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State register
    reg [2:0] state;

    // States
    parameter S = 3'b000;
    parameter S1 = 3'b001;
    parameter S11 = 3'b010;
    parameter S110 = 3'b011;
    parameter DONE = 3'b100;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
        end else begin
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= S;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S110;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= DONE;
                    end else begin
                        state <= S;
                    end
                end
                DONE: begin
                    state <= DONE;
                end
                default: begin
                    state <= S;
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        if (state == DONE) begin
            start_shifting = 1'b1;
        end else begin
            start_shifting = 1'b0;
        end
    end

endmodule
