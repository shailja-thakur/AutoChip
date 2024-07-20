module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the state encoding
    parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk, negedge aresetn) begin
        if(!aresetn) begin
            state <= S0;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            case(state)
                S0: begin
                    if(x) begin
                        next_state <= S1;
                        z <= 1'b0;
                    end
                    else begin
                        next_state <= S0;
                        z <= 1'b0;
                    end
                end
                S1: begin
                    if(x) begin
                        next_state <= S2;
                        z <= 1'b0;
                    end
                    else begin
                        next_state <= S0;
                        z <= 1'b0;
                    end
                end
                S2: begin
                    if(x) begin
                        next_state <= S1;
                        z <= 1'b1;
                    end
                    else begin
                        next_state <= S0;
                        z <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
