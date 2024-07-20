module top_module(
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [23:0] message;
    reg [1:0] state;
    reg [2:0] counter;
    wire byte1;
    wire byte2;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            message <= 24'b0;
            counter <= 3'b000;
            out_bytes <= 24'b0;
            done <= 0;
        end
        else begin
            case (state)
                2'b00: begin
                    if (in[3]) begin
                        state <= 2'b01;
                        message <= {in, 16'b0};
                        counter <= 3'b001;
                    end
                end
                2'b01: begin
                    if (byte1) begin
                        if (counter == 3'b010) begin
                            state <= 2'b10;
                        end
                        else begin
                            state <= 2'b01;
                        end
                        message <= {in[7:0], message[23:8]};
                        counter <= counter + 1;
                    end
                    else begin
                        state <= 2'b00;
                        counter <= 3'b000;
                    end
                end
                2'b10: begin
                    state <= 2'b00;
                    counter <= 3'b000;
                    out_bytes <= {message[23:16], message[15:8], message[7:0]};
                    done <= 1;
                end
            endcase
        end
    end

    assign byte1 = (state == 2'b01 && counter == 3'b001);
    assign byte2 = (state == 2'b01 && counter == 3'b010);
    
endmodule
