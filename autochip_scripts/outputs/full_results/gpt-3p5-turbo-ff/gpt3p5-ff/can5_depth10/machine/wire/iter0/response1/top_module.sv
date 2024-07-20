module top_module(
    input wire clk,
    input wire rst,
    output reg out);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    reg valid;

    initial begin
        state <= 2'b00;
        counter <= 8'b0;
        data <= 8'b0;
        valid <= 1'b0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            counter <= 8'b0;
            data <= 8'b0;
            valid <= 1'b0;
        end else begin
            case (state)
                2'b00: begin
                    counter <= 8'b0;
                    data <= 8'b0;
                    valid <= 1'b0;
                    state <= 2'b01;
                end
                2'b01: begin
                    counter <= counter + 1;
                    data <= 8'b0;
                    state <= (counter == 8'hFF) ? 2'b10 : 2'b01;
                end
                2'b10: begin
                    data <= in;
                    state <= 2'b11;
                end
                2'b11: begin
                    valid <= 1'b1;
                    state <= 2'b00;
                end
            endcase
        end
    end

    assign out = data;

endmodule
