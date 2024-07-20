module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg [7:0] data;
    reg start;
    reg stop;
    reg error;
    reg done;

    always @(posedge clk) begin
        if(reset) begin
            state <= 3'b000;
            data <= 8'b0;
            start <= 1'b0;
            stop <= 1'b0;
            error <= 1'b0;
            done <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // Idle state
                    if(in == 1'b0) begin
                        state <= 3'b001;
                        start <= 1'b1;
                        error <= 1'b0;
                        done <= 1'b0;
                    end
                end
                3'b001: begin // Start bit received, waiting for data bits
                    if(in == 1'b1) begin
                        state <= 3'b010;
                        start <= 1'b0;
                        error <= 1'b1;
                        done <= 1'b0;
                    end else begin
                        data <= {data[6:0], in};
                    end
                end
                3'b010: begin // Waiting for all data bits to be received
                    if(in == 1'b0) begin
                        data <= {data[6:0], in};
                    end else begin
                        state <= 3'b011;
                    end
                end
                3'b011: begin // Stop bit received, verifying if it is correct
                    if(in == 1'b1) begin
                        stop <= 1'b1;
                        if(data == 8'b0) begin
                            error <= 1'b1;
                            done <= 1'b0;
                        end else begin
                            error <= 1'b0;
                            done <= 1'b1;
                        end
                    end else begin
                        stop <= 1'b0;
                        error <= 1'b1;
                        done <= 1'b0;
                    end
                    state <= 3'b000;
                end
                default: begin
                    state <= 3'b000;
                    data <= 8'b0;
                    start <= 1'b0;
                    stop <= 1'b0;
                    error <= 1'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end
endmodule
