module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    reg [1:0] state;
    reg [7:0] data;
    reg start;
    reg stop;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            switch (state) begin
                case (IDLE) begin
                    if (in == 1'b0) begin
                        state <= START;
                        start <= 1'b1;
                    end
                end
                case (START) begin
                    if (in == 1'b1) begin
                        state <= DATA;
                        data <= 8'h0;
                    end
                end
                case (DATA) begin
                    if (in == 1'b0) begin
                        data <= data + in;
                    end else if (in == 1'b1) begin
                        state <= STOP;
                        stop <= 1'b1;
                    end
                end
                case (STOP) begin
                    if (in == 1'b0) begin
                        state <= IDLE;
                        done <= 1'b1;
                    end
                end
            endcase
        end
    end

endmodule