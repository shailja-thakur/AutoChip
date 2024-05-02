module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    reg [1:0] state = 2'b00;
    reg [1:0] next_state;
    reg z;

    always @(posedge clk or posedge aresetn) begin
        if (aresetn == 1'b0) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (x == 1'b1) begin
                        next_state <= 2'b01;
                        z <= 1'b0;
                    end else begin
                        next_state <= 2'b00;
                        z <= 1'b0;
                    end
                end
                2'b01: begin
                    if (x == 1'b0) begin
                        next_state <= 2'b10;
                        z <= 1'b0;
                    end else begin
                        next_state <= 2'b01;
                        z <= 1'b0;
                    end
                end
                2'b10: begin
                    if (x == 1'b1) begin
                        next_state <= 2'b11;
                        z <= 1'b1;
                    end else begin
                        next_state <= 2'b10;
                        z <= 1'b0;
                    end
                end
                2'b11: begin
                    if (x == 1'b0) begin
                        next_state <= 2'b00;
                        z <= 1'b0;
                    end else begin
                        next_state <= 2'b11;
                        z <= 1'b0;
                    end
                end
            endcase
            state <= next_state;
        end
    end

    assign z = state[1];

endmodule