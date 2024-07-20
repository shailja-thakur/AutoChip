module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;
    reg start_shifting;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else begin
            case (state)
                4'b0000: if (data) begin
                              state <= 4'b0001;
                              start_shifting <= 0;
                          end
                          else begin
                              state <= 4'b0000;
                              start_shifting <= 0;
                          end

                4'b0001: if (data) begin
                              state <= 4'b0010;
                              start_shifting <= 0;
                          end
                          else begin
                              state <= 4'b0000;
                              start_shifting <= 0;
                          end

                4'b0010: if (data) begin
                              state <= 4'b0011;
                              start_shifting <= 0;
                          end
                          else begin
                              state <= 4'b0000;
                              start_shifting <= 0;
                          end

                4'b0011: if (~data) begin
                              state <= 4'b0100;
                              start_shifting <= 0;
                          end
                          else begin
                              state <= 4'b0000;
                              start_shifting <= 0;
                          end

                4'b0100: if (data) begin
                              state <= 4'b0010;
                              start_shifting <= 0;
                          end
                          else begin
                              state <= 4'b0000;
                              start_shifting <= 0;
                          end

                default: state <= 4'b0000;
            endcase
        end
    end

endmodule
