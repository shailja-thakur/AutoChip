module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // Insert your code below
    
    // State transition logic
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= '00;
        end else begin
            case (state)
                '00:
                    if (in == 0) begin
                        state <= '01;
                    end else begin
                        state <= '00;
                    end
                '01:
                    if (in == 0) begin
                        state <= '02;
                    end else begin
                        state <= '01;
                    end
                '02:
                    if (in == 0) begin
                        state <= '03;
                    end else begin
                        state <= '02;
                    end
                '03:
                    if (in == 0) begin
                        state <= '01;
                    end else begin
                        state <= '03;
                    end
            endcase
        end
    end
    
    // State flip-flops with asynchronous reset
    reg [1:0] q;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= '00;
        end else begin
            q <= state;
        end
    end
    
    // Output logic
    assign out = q[1];

endmodule