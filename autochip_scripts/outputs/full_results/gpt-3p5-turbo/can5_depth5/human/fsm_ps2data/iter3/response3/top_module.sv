module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    
    reg [23:0] message;
    reg [2:0] state = 0;
    reg [1:0] counter = 0;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            message <= 0;
            counter <= 0;
        end else begin
            if (state == 0) begin
                if (in[3] == 1) begin
                    state <= 1;
                    counter <= 0;
                end
            end else if (state == 1) begin
                if (in[3] == 1) begin
                    state <= 2;
                    counter <= 0;
                end else if (counter < 2) begin
                    counter <= counter + 1;
                end else begin
                    state <= 0;
                end
            end else if (state == 2) begin
                if (in[3] == 1) begin
                    state <= 3;
                    counter <= 0;
                end else if (counter < 2) begin
                    counter <= counter + 1;
                end else begin
                    state <= 0;
                end
            end else if (state == 3) begin
                if (counter < 2) begin
                    counter <= counter + 1;
                end else begin
                    state <= 0;
                    counter <= 0;
                    message <= {message[15:0], in};
                end
            end
        end
    end
    
    assign done = (state == 3);
    assign out_bytes = done ? message : 24'hzzzzzz;

endmodule
