module top_module (
    input clk,
    input reset,
    output [3:0] q);

    reg [3:0] counter;
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 1'b0;
        end else begin
            case (state)
                2'b00: counter <= counter + 1;
                2'b01: counter <= counter + 2;
                2'b10: counter <= counter + 4;
                2'b11: counter <= counter + 8;
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
        end else begin
            case (counter)
                10'h0: state <= 2'b00;
                10'h1: state <= 2'b01;
                10'h2: state <= 2'b10;
                10'h3: state <= 2'b11;
                10'h4: state <= 2'b00;
                10'h5: state <= 2'b01;
                10'h6: state <= 2'b10;
                10'h7: state <= 2'b11;
                10'h8: state <= 2'b00;
                10'h9: state <= 2'b01;
                10'ha: state <= 2'b10;
                10'hb: state <= 2'b11;
            endcase
        end
    end

    assign q = counter;

endmodule