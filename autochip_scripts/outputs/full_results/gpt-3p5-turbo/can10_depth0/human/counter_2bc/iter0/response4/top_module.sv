module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    reg [1:0] counter;

    always @(posedge clk or posedge areset) begin
        if (areset == 1'b1) begin
            counter <= 2'b01;
        end else begin
            if (train_valid == 1'b1) begin
                if (train_taken == 1'b1) begin
                    if (counter < 2'b11) begin
                        counter <= counter + 1;   
                    end
                end else if (train_taken == 1'b0) begin
                    if (counter > 2'b00) begin
                        counter <= counter - 1;
                    end
                end
            end
        end
    end
    
    assign state = counter;

endmodule
