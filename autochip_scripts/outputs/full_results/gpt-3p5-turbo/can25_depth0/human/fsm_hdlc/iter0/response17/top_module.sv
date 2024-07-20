module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg [1:0] count;
    reg disc_reg;
    reg flag_reg;
    reg err_reg;

    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err = err_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            count <= 2'b00;
            disc_reg <= 1'b0;
            flag_reg <= 1'b0;
            err_reg <= 1'b0;
        end else begin
            case(state)
                3'b000: begin // Initial state
                    if(in) begin
                        state <= 3'b001;
                        count <= 2'b01;
                    end else begin
                        state <= 3'b000;
                        count <= 2'b00;
                    end
                end
                3'b001: begin // Input 0->1 transition state
                    if(in) begin
                        state <= 3'b010;
                        count <= 2'b01;
                    end else begin
                        state <= 3'b000;
                        count <= 2'b00;
                    end
                end
                3'b010: begin // Counting state
                    if(in) begin
                        count <= count + 1'b1;
                        if(count == 2'b01) begin
                            if(in) begin
                                state <= 3'b011;
                                count <= 2'b01;
                            end else begin
                                state <= 3'b010;
                                count <= 2'b00;
                            end
                        end
                    end else begin
                        state <= 3'b000;
                        count <= 2'b00;
                    end
                end
                3'b011: begin // Check for flag or error
                    if(in) begin
                        if(count == 2'b01) begin
                            if(in) begin
                                state <= 3'b100;
                                count <= 2'b00;
                            end else begin
                                state <= 3'b011;
                                count <= 2'b00;
                            end
                        end
                    end else begin
                        state <= 3'b000;
                        count <= 2'b00;
                    end
                end
                3'b100: begin // State after receiving a flag
                    if(in) begin
                        state <= 3'b011;
                        count <= 2'b01;
                        disc_reg <= 1'b1;
                        flag_reg <= 1'b0;
                        err_reg <= 1'b0;
                    end else begin
                        state <= 3'b000;
                        count <= 2'b00;
                        disc_reg <= 1'b0;
                        flag_reg <= 1'b1;
                        err_reg <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
