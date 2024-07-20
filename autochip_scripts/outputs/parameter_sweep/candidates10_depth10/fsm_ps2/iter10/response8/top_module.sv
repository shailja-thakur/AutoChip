module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg done
);

    reg [2:0] count = 0;
    reg [1:0] state = 0;
    wire in3 = in[3];

    localparam [1:0]
        IDLE = 2'b00,
        SEARCH = 2'b01,
        DONE = 2'b10;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in3) begin
                        state <= SEARCH;
                        count <= 1;
                    end
                end
                SEARCH: begin
                    case (count)
                        2'b00: begin
                            if (in3) begin
                                count <= count + 1;
                            end else begin
                                state <= IDLE;
                                count <= 0;
                            end
                        end
                        2'b01: begin
                            if (in3) begin
                                count <= 0;
                                state <= DONE;
                                done <= 1;
                            end else begin
                                state <= IDLE;
                                count <= 0;
                            end
                        end
                    endcase
                end
                DONE: begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
