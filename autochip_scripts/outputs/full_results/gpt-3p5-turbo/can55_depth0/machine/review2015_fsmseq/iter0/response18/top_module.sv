module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;
    reg start_shift;

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'bS;
        end else begin
            case (state)
                4'bS:
                    if (data) begin
                        state <= 4'bS1;
                    end else begin
                        state <= 4'bS;
                    end
                4'bS1:
                    if (data) begin
                        state <= 4'bS11;
                    end else begin
                        state <= 4'bS;
                    end
                4'bS11:
                    if (data) begin
                        state <= 4'bS11;
                    end else begin
                        state <= 4'bS110;
                    end
                4'bS110:
                    if (data) begin
                        state <= 4'bDone;
                    end else begin
                        state <= 4'bS;
                    end
                4'bDone:
                    state <= 4'bDone;
            endcase
        end
    end

    assign start_shifting = (state == 4'bDone);

endmodule
