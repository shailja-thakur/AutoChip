    always@(posedge clk, posedge areset)
		if (areset) begin
			predict_history = 0;
        end	else begin
			if (train_mispredicted)
				predict_history <= {train_history, train_taken};
			else if (predict_valid)
				predict_history <= {predict_history, predict_taken};
		end
endmodule
