module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);
    
    reg [2:0] state;
    reg [5:0] counter;
    wire [5:0] zeros;
    
    // Detect 6 consecutive ones
    assign zeros = (counter == 5);
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            counter <= 0;
        end else begin
            case (state)
                0: begin
                    if (in) begin
                        state <= 1;
                        counter <= 1;
                    end
                end
                1: begin
                    if (in) begin
                        if (zeros) begin
                            state <= 2;
                            counter <= 0;
                            flag <= 1;
                            disc <= 0;
                        end else if (counter == 6) begin
                            state <= 3;
                            counter <= 0;
                            flag <= 0;
                            disc <= 0;
                        end else if (counter >= 7) begin
                            state <= 3;
                            counter <= 0;
                            flag <= 0;
                            disc <= 0;
                            err <= 1;
                        end else begin
                            counter <= counter + 1;
                        end
                    end else begin
                        state <= 0;
                        counter <= 0;
                        flag <= 0;
                        disc <= 0;
                        err <= 0;
                    end
                end
                2: begin
                    state <= 1;
                    if (in) begin
                        counter <= 1;
                    end else begin
                        counter <= 0;
                        disc <= 1;
                    end
                end
                3: begin
                    state <= 1;
                    if (in) begin
                        counter <= 1;
                    end else begin
                        counter <= 0;
                        disc <= 0;
                        err <= 0;
                    end
                end
            endcase
        end
    end
endmodule
