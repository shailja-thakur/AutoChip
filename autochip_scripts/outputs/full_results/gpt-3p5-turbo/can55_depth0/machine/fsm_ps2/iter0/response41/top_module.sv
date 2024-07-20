module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [2:0] state;

    // State definitions
    parameter BYTE1 = 3'b000;
    parameter BYTE2 = 3'b001;
    parameter BYTE3 = 3'b010;
    parameter DONE = 3'b011;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            done <= 0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1'b1)
                        state <= BYTE2;
                    else
                        state <= BYTE1;
                end

                BYTE2: begin
                    state <= BYTE3;
                end

                BYTE3: begin
                    state <= DONE;
                end

                DONE: begin
                    if (in[2] == 1'b1)
                        state <= BYTE2;
                    else
                        state <= BYTE1;
                end
            endcase
        end
    end

    // Output assignment
    assign done = (state == DONE);

endmodule
