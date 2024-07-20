module top_module(
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output wire [23:0] out_bytes,
    output wire done
);
    reg [23:0] message;
    reg [2:0] state;
    reg [2:0] counter;
    wire byte1;
    wire byte2;
    
    initial begin
        state = 3'b000;
        message = 24'b0;
        counter = 3'b000;
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            message <= 24'b0;
            counter <= 3'b000;
        end
        else begin
            case (state)
                3'b000: begin
                    if (in[3]) begin
                        state <= 3'b001;
                        message <= {16'b0, in};
                        counter <= 3'b001;
                    end
                end
                3'b001: begin
                    if (byte2) begin
                        state <= 3'b010;
                    end
                    else if (byte1) begin
                        state <= 3'b001;
                        message <= {in, message[23:8]};
                        counter <= counter + 1;
                    end
                end
                3'b010: begin
                    state <= 3'b000;
                    counter <= 3'b000;
                end
            endcase
        end
    end

    assign byte1 = (state == 3'b001 && counter == 3'b001);
    assign byte2 = (state == 3'b001 && counter == 3'b010);
    
    assign out_bytes = byte2 ? {message[23:16], message[15:8], message[7:0]} : 24'b0;
    assign done = (state == 3'b010 && counter == 3'b000);
    
endmodule
